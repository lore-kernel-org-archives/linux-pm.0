From: "Yu, Luming" <luming.yu@intel.com>
Subject: Re: swsusp: Not enough free pages
Date: Mon, 30 May 2005 17:14:19 +0800
Message-ID: <20050530091419.GA7922@linux.sh.intel.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
	<42935C72.9030506@suse.de>
	<20050525012040.GA6145@linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============54426907670554359=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050525012040.GA6145@linux.sh.intel.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Seyfried <seife@suse.de>, ACPI devel <acpi-devel@lists.sourceforge.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

--===============54426907670554359==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2005.05.25 09:20:41 +0800, Yu, Luming wrote:
> On 2005.05.25 00:55:14 +0800, Stefan Seyfried wrote:
> > 
> >    Yu, Luming wrote:
> >    > Hi Pavel,
> >    >
> >    > I got this error when I'm hacking suspend-to-disk on my IA64 box
> >    with 1G
> >    > memory.
> >    > (Pagesize 64K,MemTotal:  1002112 kB ,MemFree:  395008 kB)
> >    > Do you plan to improve it by compressing pages ?
> >    >
> >    > swsusp: Need to copy 9878 pages
> >    > suspend: (pages needed: 9878 + 512 free: 6486)
> >    > swsusp: Not enough free pages: Have 6486
> >    I have not seen one of those for a long time (on i386). Does this
> >    happen
> >    every time? 
> 
> So far, yes. I just tried 2 times.

always. (I check that swap dev is on)

Sometimes, my ia32 laptop free 0 pages too.
I think we should always free some pages 
from various caches. 

Thanks,
Luming 



--===============54426907670554359==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============54426907670554359==--
