From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Wed, 4 Jan 2006 17:06:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601041703350.26871-100000@iolanthe.rowland.org>
References: <20060104213405.GC1761@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46109414103194346=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060104213405.GC1761@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============46109414103194346==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 4 Jan 2006, Pavel Machek wrote:

> > As I mentioned in the thread (currently happening, BTW) on the linux-pm
> > list, what you want to do is accept a string that reflects an actual state
> > that the device supports. For PCI devices that support low-power states,
> > this would be "D1", "D2", "D3", etc. For USB devices, which only support
> > an "on" and "suspended" state, the values that this patch parses would
> > actually work.
> 
> We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
> "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
> and I'm not sure about those "D1" and "D2" parts. Userspace should not
> have to know about details, it will mostly use "on"/"suspend" anyway.

It would be good to make the details available so that they are there when
needed.  For instance, we might export "D0", "on", "D1", "D2", "D3", and
"suspend", treating "on" as a synonym for "D0" and "suspend" as a synonym
for "D3".

Alan Stern


--===============46109414103194346==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46109414103194346==--
