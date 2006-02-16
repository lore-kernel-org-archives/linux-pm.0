From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Date: Thu, 16 Feb 2006 23:39:46 +0100
Message-ID: <20060216223945.GK3490@openzaurus.ucw.cz>
References: <20060208125753.GA25562@srcf.ucam.org>
	<20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de>
	<200602142117.31232.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77884363545987056=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602142117.31232.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, Stefan Seyfried <seife@suse.de>, Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============77884363545987056==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > AMD64 laptops are booting with lower freqs per default until they are
> > pushed up, so there shouldn't be anything critical?
> 
> This is not true as far as my box is concerned (Asus L5D).  It starts with
> the _highest_ clock available.

Not all laptops have underpowered batteries. And I have
seen machine that booted fast with underpowered battery...
not nice. Would crash in POST in 30% cases.
> 
> > For the brightness part, I don't see any "laptop is going to explode"
> > issue.
> > I always hated the brightness going down when I unplugged ac on M_
> 
> Currently I have the same problem on Linux, but I don't know the solution
> (yet).  Any hints? :-)

Work around acpi bios... not going to be nice.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============77884363545987056==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77884363545987056==--
