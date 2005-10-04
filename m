From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Update on USB PM state (2.6.15 queue)
Date: Tue, 4 Oct 2005 15:03:31 +0200
Message-ID: <20051004130330.GA9282@openzaurus.ucw.cz>
References: <200509280957.06073.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============067196956135326946=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200509280957.06073.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============067196956135326946==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

>         * Those other systems don't have any better luck
>           when the S1/S3 resume signal is a USB wakeup than
>           any other kind of wakeup.
> 
> Compared to the last time I tested this, it's good to at least
> see the USB remote wakeup signals waking the system up; those
> seem to be ACPI improvements.  But it still looks like the
> cases I most want to see working (S1, S3) are failing on PCs.

Look at Doc*/power/video.txt, there's long list of working systems in it.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============067196956135326946==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============067196956135326946==--
