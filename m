From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: [PATCH RFC] provide information whether requested
	firmware is bult-in
Date: Sun, 12 Oct 2008 16:18:46 +0400
Message-ID: <200810121618.48830.arvidjaar__100.57919794253$1223814240$gmane$org@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4665348614414185230=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
Cc: Dave <kilroyd@googlemail.com>
List-Id: linux-pm@vger.kernel.org

--===============4665348614414185230==
Content-Type: multipart/signed;
  boundary="nextPart3385729.I7qfuf3LGH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3385729.I7qfuf3LGH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

As indicated by several threads on lkml, currently the only safe way
to reload external firmware in resume method is to cache it in memory.
In this case if firmware was already built in, we just create useless
copy. The patch suggests framework which can be used to return information
whether firmware was loaded dynamically or already available in memory.
Requestor can check it to decide whether local copy is required.

Alternative would be request_cached_firwmare() function to manage
cache in one place. =20

Comments? Is there any other reliable way to ensure firmware can be
loaded on resume?

=2Dandrey

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index c9c92b0..525561a 100644
=2D-- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -415,6 +415,7 @@ _request_firmware(const struct firmware **firmware_p, c=
onst char *name,
 		       name);
 		firmware->size =3D builtin->size;
 		firmware->data =3D builtin->data;
+		firmware->flags |=3D FW_FL_BUILTIN;
 		return 0;
 	}
=20
@@ -491,13 +492,8 @@ release_firmware(const struct firmware *fw)
 	struct builtin_fw *builtin;
=20
 	if (fw) {
=2D		for (builtin =3D __start_builtin_fw; builtin !=3D __end_builtin_fw;
=2D		     builtin++) {
=2D			if (fw->data =3D=3D builtin->data)
=2D				goto free_fw;
=2D		}
=2D		vfree(fw->data);
=2D	free_fw:
+		if (!(fw->flags&FW_FL_BUILTIN))
+			vfree(fw->data);
 		kfree(fw);
 	}
 }
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index c8ecf5b..0c6c232 100644
=2D-- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -9,9 +9,12 @@
 #define FW_ACTION_NOHOTPLUG 0
 #define FW_ACTION_HOTPLUG 1
=20
+#define FW_FL_BUILTIN	(1<<0) /* Firmware image is built in kernel */
+
 struct firmware {
 	size_t size;
 	const u8 *data;
+	unsigned short flags;
 };
=20
 struct device;

--nextPart3385729.I7qfuf3LGH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjx6ygACgkQR6LMutpd94wemgCfe9IcMaCznQfr8Y6jwf0bNVtz
lbIAn3xqJdFGMtcwyczRRDbDZeRVb/ns
=NO+J
-----END PGP SIGNATURE-----

--nextPart3385729.I7qfuf3LGH--

--===============4665348614414185230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4665348614414185230==--
