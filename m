From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Tue, 9 Sep 2008 10:22:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809091019190.2486-100000__34525.4757129171$1220970353$gmane$org@iolanthe.rowland.org>
References: <200809091345.31785.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809091345.31785.rjw@sisk.pl>
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 9 Sep 2008, Rafael J. Wysocki wrote:

> Still, I'm not sure if we need the method at the device core level at all.
> 
> The suspend/resume callbacks are needed at the device core level, because the
> _core_ initiates the operation (suspend, resume etc.), but in this case the
> operation will be initiated in a core-independent way (for example, by an
> interrupt handler in case of the PCI Express native PME).

Not only the wakeup (resume) operation, but also the original suspend 
operation.

> Surely, we'll need such a callback on the PCI core level that may have to
> invoke the device driver to handle wake-up after identifying the device that
> caused the event to happen.

Absolutely.  This could involve calling the normal PCI resume method or 
it could involve a new method.  Presumably it will mirror whatever 
means we choose for implementing runtime suspend (e.g., a pair of new 
methods).

Alan Stern
