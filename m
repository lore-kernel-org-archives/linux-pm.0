From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: WARNING: at kernel/resource.c:189 __release_resource
Date: Tue, 27 Nov 2007 05:38:52 -0700
Message-ID: <20071127123852.GB3230__25312.2337664992$1196178321$gmane$org@parisc-linux.org>
References: <4745F77C.7040402@gmail.com>
	<20071126220538.1aed9c33.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071126220538.1aed9c33.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Greg KH <gregkh@suse.de>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net, linux-pm@lists.linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 26, 2007 at 10:05:38PM -0800, Andrew Morton wrote:
> On Thu, 22 Nov 2007 22:41:16 +0100 Jiri Slaby <jirislaby@gmail.com> wrote:
> > Step aside. What's the purpose of having two similar patches for one issue,
> > it then warns about the same thing twice:
> > make-sure-nobodys-leaking-resources.patch
> > releasing-resources-with-children.patch
> 
> Oh well.  It's better than having none.  Matthew, could you have think
> about something for mainline please?

I submitted it for mainline.  I was never quite sure why you only took
it into -mm.  I'll take a look at what you have in -mm these days.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
