From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Thu, 16 Feb 2006 23:44:40 +0100
Message-ID: <20060216224439.GL3490@openzaurus.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org>
	<20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de>
	<200602142117.31232.rjw@sisk.pl> <43F3206B.6090902@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============34846981832221879=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <43F3206B.6090902@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Thomas Renninger <trenn@suse.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============34846981832221879==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> >This is not true as far as my box is concerned 
> >(Asus L5D).  It starts with
> >the _highest_ clock available.
> Hmm, but then there shouldn't be any critical 
> overheat problems and if,
> the hardware has to switch off the machine 
> hard. OS always could freeze,
> but the battery must not start to burn...

I told that to hw designers... too late. Fortunately batteries usually
only crash machine if you overload them.

> IMO, the /sys/.../brightness patch should go in 
> as soon as possible, I think
> all everybody agrees here?

Yep.

> Maybe I oversaw an issue, but I really don't 
> see a reason for connecting
> the brightness to ac in kernel space.

We are not going to connect it. But to implement .../brightness, you need to
know ac/battery on several "broken" notebooks.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============34846981832221879==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============34846981832221879==--
