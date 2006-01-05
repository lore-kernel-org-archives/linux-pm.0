From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [patch] pm: fix runtime powermanagement's /sys
	interface
Date: Thu, 5 Jan 2006 09:16:12 -0600 (CST)
Message-ID: <200601051516.k05FGC5d023781@olwen.urbana.css.mot.com>
Content-Type: multipart/mixed; boundary="===============26103097005026354=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Wed, 4 Jan 2006 23:16:56 +0100
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@suse.cz
Cc: akpm@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============26103097005026354==


My inclination would be to have the sysfs interface know generic terms,
with the implementation mapping them to device-specific terms. It ought
to be possible to build portable tools that don't have to know about
device-specific states and have the device interfaces (in sysfs) do the
necessary translation.

However, I also think there is value in having the sysfs interface
recognize the device-specific values as well, so that device-specific
tools can also be written (offering the option of taking advantage of
special capabilities of a particular device).

scott

| On St 04-01-06 17:06:09, Alan Stern wrote:
| > On Wed, 4 Jan 2006, Pavel Machek wrote:
| > 
| > > > As I mentioned in the thread (currently happening, BTW) on the linux-pm
| > > > list, what you want to do is accept a string that reflects an actual state
| > > > that the device supports. For PCI devices that support low-power states,
| > > > this would be "D1", "D2", "D3", etc. For USB devices, which only support
| > > > an "on" and "suspended" state, the values that this patch parses would
| > > > actually work.
| > > 
| > > We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
| > > "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
| > > and I'm not sure about those "D1" and "D2" parts. Userspace should not
| > > have to know about details, it will mostly use "on"/"suspend" anyway.
| > 
| > It would be good to make the details available so that they are there when
| > needed.  For instance, we might export "D0", "on", "D1", "D2", "D3", and
| > "suspend", treating "on" as a synonym for "D0" and "suspend" as a synonym
| > for "D3".
| 
| Why to make it this complex?
| 
| I do not think there's any confusion possible. "on" always corresponds
| to "D0", and "suspend" is "D3". Anyone who knows what "D2" means,
| should know that, too...
| 							Pavel
| -- 
| Thanks, Sharp!
| 
| --===============85566774732936779==
| ----------
| _______________________________________________
| linux-pm mailing list
| linux-pm@lists.osdl.org
| https://lists.osdl.org/mailman/listinfo/linux-pm
| 
| --===============85566774732936779==--

-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com



--===============26103097005026354==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26103097005026354==--
