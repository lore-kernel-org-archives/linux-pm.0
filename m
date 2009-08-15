From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] PCI: Runtime power management
Date: Sat, 15 Aug 2009 21:58:17 +0100
Message-ID: <20090815205817.GA30254__18541.238041553$1250369967$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.0908151143560.18415-100000@netrider.rowland.org>
	<200908152254.23227.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908152254.23227.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 15, 2009 at 10:54:23PM +0200, Rafael J. Wysocki wrote:

> runtime_wakeup - if set, the device is allowed to do remote wakeup at run time
>   That could be represented as 'runtime_wakeup' under 'power' with the
>   following values:
>   * no value (empty file) is 'runtime' is 'disabled'
>   * 'enabled'
>   * 'disabled'
>   To set/unset the user space writes 'enabled'/'disabled' to it, respectively.
>   The default is set.

Why would you ever want runtime_wakeup to be false unless 
runtime_forbidden is true? Surely the point of runtime power management 
is to be transparent to the user, in which case remote wakeup is 
required?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
