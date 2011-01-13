From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 4/9] cpuidle: Introduce .abbr (abbrevation)
	for cpuidle states
Date: Thu, 13 Jan 2011 10:42:29 -0500
Message-ID: <13258.1294933349__18512.6017583118$1294933718$gmane$org@localhost>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
	<1294396190-23031-5-git-send-email-trenn@suse.de>
	<alpine.LFD.2.02.1101120150570.19140@x980>
	<201101121437.51122.trenn@suse.de>
	<alpine.LFD.2.02.1101121705130.19754@x980>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4799380464049189331=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: Your message of "Wed, 12 Jan 2011 17:25:12 EST."
	<alpine.LFD.2.02.1101121705130.19754@x980>
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
To: Len Brown <lenb@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, j-pihet@ti.com, linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-omap@vger.kernel.org, arjan@linux.intel.com
List-Id: linux-pm@vger.kernel.org

--===============4799380464049189331==
Content-Type: multipart/signed; boundary="==_Exmh_1294933349_5688P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1294933349_5688P
Content-Type: text/plain; charset=us-ascii

On Wed, 12 Jan 2011 17:25:12 EST, Len Brown said:

> > But by sysfs convention a separate file must be used
> > if two data are passed to userspace which is the case here.
> 
> what two data?
> 
> It is fine for a string to include space characters.

I think Thomas is concerned that although when you actually read a /sys
file, you know it's one string, that fact can get easily lost and cause issues
down the road. Consider this code:

foo=`cat /sys/some/file`
bar=`cat /sys/other/file`
baz=`cat /sys/third/file`
echo $foo $bar $baz | awk '{print $2 $3}'

Suddenly your output isn't what you expected...

--==_Exmh_1294933349_5688P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFNLx1lcC3lWbTT17ARAh+5AKDO3njvfdeLwHRolBhga5tdWk17GQCfQjna
5NRZO5tAIu4zmvbxJ2zLUe4=
=B2BS
-----END PGP SIGNATURE-----

--==_Exmh_1294933349_5688P--


--===============4799380464049189331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4799380464049189331==--
