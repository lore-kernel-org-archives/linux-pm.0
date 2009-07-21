From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Driver core: make pm operations a const
	pointer
Date: Tue, 21 Jul 2009 09:42:12 -0700
Message-ID: <20090721164212.GA14493__28321.4097413749$1248194952$gmane$org@suse.de>
References: <20090721055136.GB4671@dtor-d630.eng.vmware.com>
	<200907211546.49906.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200907211546.49906.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 21, 2009 at 03:46:49PM +0200, Rafael J. Wysocki wrote:
> Hi Dmitry,
> 
> Please always Cc linux-pm on PM-related patches.
> 
> On Tuesday 21 July 2009, Dmitry Torokhov wrote:
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > They are not supposed to be modified by drivers, so make them const.
> 
> OK, I guess I should handle this.
> 
> Greg, is the patch fine with you?

Yes, feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

thanks,

greg k-h
