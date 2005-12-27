From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Runtime device power management in userspace
Date: Tue, 27 Dec 2005 11:29:56 -0800
Message-ID: <20051227192956.GA10704@digitalimplant.org>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
	<20051224004029.GC16043@elf.ucw.cz>
	<Pine.LNX.4.50.0512261234350.12383-100000@monsoon.he.net>
	<20051226223325.GE1974@elf.ucw.cz>
	<Pine.LNX.4.50.0512271054350.30915-100000@monsoon.he.net>
	<20051227192254.GJ1822@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============51228144213142768=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051227192254.GJ1822@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============51228144213142768==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 27, 2005 at 08:22:54PM +0100, Pavel Machek wrote:

> I don't really think we want complexity of putting PCI device into
> D0/D1/D2/D3hot/D3cold. All that userspace should care about is device
> working/device suspended, and we could not test all 5 states, anyway.

What do you mean? 

The devices and drivers should support various states, and that's the
whole point of having multiple states - to make a choice based on the
power saving required vs. the latency requirements of bringing it back.

Granted, for most things, the latency to return from D3 (hot only, cold
is irrelevant during runtime) is not going to be noticable, so that's
probably the only state most devices will ever enter. 

But, in some cases, peple are going to care about the intermediate
states, and we'll need to support them. It's simple enought to know
what states a PCI device supports, so I don't understand where the
complexity comes in.. ?


	Patrick


--===============51228144213142768==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============51228144213142768==--
