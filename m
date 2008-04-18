From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.25-mm1: suspend-to-disk warning, resume failure
Date: Fri, 18 Apr 2008 04:33:29 -0700
Message-ID: <20080418043329.e08241b1.akpm@linux-foundation.org>
References: <20080417222125.99e807b6.akpm@linux-foundation.org>
	<20080418110440.GA5455@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080418110440.GA5455@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-usb@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 18 Apr 2008 13:08:13 +0200 Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > This is the Vaio.
> > 
> > This:
> > 
> > <cold boot>
> > <suspend-to-ram>
> > <resume-from-ram>
> > <suspend-to-ram>
> > <resume-from-ram>
> > 
> > works OK.
> > 
> > 
> > This:
> > 
> > <cold boot>
> > <suspend-to-disk>
> > <resume-from-disk>
> > 
> > works OK.
> > 
> > 
> > But this:
> > 
> > <cold boot>
> > <suspend-to-ram>
> > <resume-from-ram>
> > <suspend-to-disk>
> > <resume-from-disk>
> 
> Works for me on thinkpad x60.
> 
> Problems I'm aware in this area: MCE driver does not like suspend
> (compile it out), and iommu has problems (iommu=soft solves it).

Yeah.  I got down to bisect the Vaio failure and it went away.  But it was
there.
