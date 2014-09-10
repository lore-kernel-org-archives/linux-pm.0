From: Valdis.Kletnieks@vt.edu
Subject: Re: suspend/resume PM criterion for application
Date: Wed, 10 Sep 2014 15:25:00 -0400
Message-ID: <23104.1410377100@turing-police.cc.vt.edu>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
	<17893.1410371984@turing-police.cc.vt.edu>
	<CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
	<20227.1410374378@turing-police.cc.vt.edu>
	<CAJ2oMhLnP7TpP3caycqVS0xHRE3tf=+2vREE6H1NradsmFmH4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3383514659559016623=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: Your message of "Wed, 10 Sep 2014 21:58:48 +0300."
	<CAJ2oMhLnP7TpP3caycqVS0xHRE3tf=+2vREE6H1NradsmFmH4A@mail.gmail.com>
List-Unsubscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-pm@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-pm@vger.kernel.org

--===============3383514659559016623==
Content-Type: multipart/signed; boundary="==_Exmh_1410377099_2058P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1410377099_2058P
Content-Type: text/plain; charset=us-ascii

On Wed, 10 Sep 2014 21:58:48 +0300, Ran Shalit said:

> 1. How can I make a process to notice this inactivity ? Do you think
> it can be implemented by some periodic process who check if there is
> activity ? It returns to the original question I raised, that I will
> use some periodic process who checks maybe cpu load or something like
> that. What do you think ?

That's going to depend on your system and what processes are running.

You may have an MP3 player going that doesn't take much CPU at all - but
shutting down because the user hasn't hit a button in 47 minutes will probably
irritate the user no end.  Or there may be a screensaver running that takes
twice as much CPU as the MP3 player, but is totally OK on the system
suspending whenever the rest of the system wants it.

You're going to have to look at your system design, and decide for yourself
what the criteria are.


> 2. What Do you mean here by process ?  Do you mean SW process which
> register for suspend notification (how do we do this) ? What about
> devices which register for suspend/resume. Must they accept the
> suspend ?

I believe Android already has libraries and monitor processes for this.

It's really hard to give more specific advice without knowing what your
hardware, software, and usage is.

--==_Exmh_1410377099_2058P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBVBCliwdmEQWDXROgAQJP8Q/+KBMaTA2o7cWrjv7iDl5Z03hpOksOfXeC
qs7U22RTJSIoZ9BRM91cEHHew6CMe0SQFmVE/Ruy9kzJ0ajs0v5qOkAtZttU+C5E
uvhZMrPEoTQT4bNRIvUYBrKHJCn1MvfJ0h1vzCI5npfSBv3j7l/w1QdEmvmNa/n7
+OQymO2tj7riDDdzb/PBoP5RucGlSNIV48mAzCH5IcbDvKcsEeftMdxwAKAm4Iul
hOTVY25MOMGeka0foqwaKlnXLaMMfrCKdCvGP2ScVKx3Egp5Htuq34eGytExfzl2
hx/nsyBHZSVPZFsZRXQrxE2ZjL4Bu9kBOpF6dpsIiywx9DK+/NhqTfKkJe2yULZE
LtANsg2agSOSR1Xq3XbemLqwCOWBDFguCTLRmv9GrbTBU/mQej2EEYmSBV2JINSi
wiD+yU/KIn02BHZEWJkp+8USA2tRxpn4k5hY3CwRv+jtiPlguwwrRB9PLPJDEXkT
xgUznoXgXD06wnexHmJTH/Uz3oLl+t9zsv5bFGpedUQCCJWv9vxDIY9yMVUzE30n
GugxCaS7ZszrpTkU5NimMujruY0VPUaQt8E+IMolOFzFDgpu8BxNe7MnyjSUTfCb
x2EqcRTEDaybuoHUtzx4jg4gjYh1YxKnvRJZ8Sn0TdjsFF79LWDoPqp/r3uOWGNh
oYaXNAklAB4=
=jZcp
-----END PGP SIGNATURE-----

--==_Exmh_1410377099_2058P--


--===============3383514659559016623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============3383514659559016623==--
