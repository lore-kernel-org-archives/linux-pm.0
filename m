From: "=?ISO-8859-1?Q?Erik_Andr=E9n?=" <erik.andren@gmail.com>
Subject: Re: [patch] hibernation: utilize ACPI hardware signature
Date: Wed, 2 Jan 2008 11:08:08 +0100
Message-ID: <62e5edd40801020208s268aeacbj96481f5a317b8ea7@mail.gmail.com>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0666108640054631749=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
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
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============0666108640054631749==
Content-Type: multipart/alternative;
	boundary="----=_Part_21169_24593906.1199268488444"

------=_Part_21169_24593906.1199268488444
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

2008/1/2, Shaohua Li <shaohua.li@intel.com>:
>
> ACPI defines a hardware signature. BIOS calculates the signature
> according to hardware configure, if hardware changes, the signature will
> change, in this case, S4 resume should fail.
>
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---


Would it be possible to extend this mechanism to prevent the following
scenario:

1. Linux image A is suspended to disk
2. Linux image B is booted and various changes to the system are done.
3. Linux image B is shut down
4. Linux image A is booted, restoring the suspend to disk image.
5. Chaos is ensured as the file system state is changed in regard to how
linux image A expects it.

Correct behaviour would naturally be that image A detects that changes have
been made under its feet and proceed to perform a normal boot instead of
resuming the stored suspend-to-disk image.

Is there another mechanism preventing this?
I remember destroying a system by doing this sequence of operations a coupl=
e
of years ago.

With kind regards,
Erik Andr=E9n


-
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

------=_Part_21169_24593906.1199268488444
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br><div><span class=3D"gmail_quote">2008/1/2, Shaohua Li &lt;<a hre=
f=3D"mailto:shaohua.li@intel.com">shaohua.li@intel.com</a>&gt;:</span><bloc=
kquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, =
204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
ACPI defines a hardware signature. BIOS calculates the signature<br>accordi=
ng to hardware configure, if hardware changes, the signature will<br>change=
, in this case, S4 resume should fail.<br><br>Signed-off-by: Shaohua Li &lt=
;
<a href=3D"mailto:shaohua.li@intel.com">shaohua.li@intel.com</a>&gt;<br>---=
</blockquote><div><br>Would it be possible to extend this mechanism to prev=
ent the following scenario:<br><br>1. Linux image A is suspended to disk<br=
>
2. Linux image B is booted and various changes to the system are done.<br>3=
. Linux image B is shut down<br>4. Linux image A is booted, restoring the s=
uspend to disk image.<br>5. Chaos is ensured as the file system state is ch=
anged in regard to how linux image A expects it.
<br><br>Correct behaviour would naturally be that image A detects that chan=
ges have been made under its feet and proceed to perform a normal boot inst=
ead of resuming the stored suspend-to-disk image.<br><br>Is there another m=
echanism preventing this?
<br>I remember destroying a system by doing this sequence of operations a c=
ouple of years ago.<br><br>With kind regards,<br>Erik Andr=E9n<br><br><br><=
/div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
-<br>To unsubscribe from this list: send the line &quot;unsubscribe linux-a=
cpi&quot; in<br>the body of a message to <a href=3D"mailto:majordomo@vger.k=
ernel.org">majordomo@vger.kernel.org</a><br>More majordomo info at&nbsp;&nb=
sp;<a href=3D"http://vger.kernel.org/majordomo-info.html">
http://vger.kernel.org/majordomo-info.html</a><br></blockquote></div><br>

------=_Part_21169_24593906.1199268488444--

--===============0666108640054631749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0666108640054631749==--
