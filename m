From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 084/123] USB: fix up suspend and resume for
	PCI host controllers
Date: Sat, 17 Jan 2009 14:21:12 +0100
Message-ID: <200901171421.12389.rjw__25395.3213956722$1232198667$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0901161805450.4593-100000@iolanthe.rowland.org>
	<1232167552.23611.20.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1232167552.23611.20.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 17 January 2009, Benjamin Herrenschmidt wrote:
> 
> > Not exactly.  Just try this patch:
> > 
> > 	http://marc.info/?l=linux-kernel&m=123184641714487&w=2
> > 
> > with vanilla 2.6.29-rc1 or rc2.
> 
> Out of curiosity, while pci_disable_device() before save_state() ?

Because on resume we call pci_restore_state() before pci_(re)enable_device().

Thanks,
Rafael
