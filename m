From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Fri, 20 Apr 2007 10:39:51 -0700
Message-ID: <20070420173951.GB14778@kroah.com>
References: <1176980411.6141.83.camel@johannes.berg>
	<20070420065731.GA5831@kroah.com>
	<1177083093.5902.3.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177083093.5902.3.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 20, 2007 at 05:31:33PM +0200, Johannes Berg wrote:
> On Fri, 2007-04-20 at 06:57 +0000, Greg KH wrote:
> 
> > Can't you just make this a "weak" symbol and override it in your ppc
> > code if you really need it, and make a "real" function here in this file
> > for all other arches?
> 
> I'm not opposed to that. How do I do that?

Look at the other examples in the kernel, pcibios_disable_device is one
such example.

thanks,

greg k-h
