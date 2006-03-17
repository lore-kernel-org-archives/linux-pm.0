From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: swsusp: which page should be saved?
Date: Fri, 17 Mar 2006 09:12:15 +0800
Message-ID: <1142557935.26706.26.camel@sli10-desk.sh.intel.com>
References: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
	<20060315230846.GB2462@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============69529257807644584=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060315230846.GB2462@ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============69529257807644584==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-03-16 at 07:08 +0800, Pavel Machek wrote:
> On Thu 16-03-06 11:53:27, Shaohua Li wrote: 
> > I thought there was a discussion before, but I still saw many pages
> like 
> > BIOS reserved are saved/restored in swsusp. Pages reserved by BIOS,
> not 
> > used by OS and kernel text should be skipped in swsusp to me. Below 
> > patch works in my test. Any thought?
> 
> This will need quite a lot of testing.
> 
> Does it actually fix anything?
No, it doesn't. Just want to speed up swsusp.

> I'm afraid that some of the BIOSs state is actually shared knowledge 
> with kernel, and that we should better save it, so that kernel's and 
> BIOS's view are consistent after resume.
Fair enough. ACPI BIOS does communicate with OS by reserved memory. But
in the mean time, blindly save/restore such mem might be dangerous. If
all ACPI devices have their suspend/resume method, reserved memory
should not be saved.

Anyway, skipping kernel text should be safe, isn't it?

Thanks,
Shaohua



--===============69529257807644584==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============69529257807644584==--
