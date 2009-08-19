From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume
	(updated)
Date: Wed, 19 Aug 2009 10:07:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908191004560.3001-100000__30270.9849355326$1250691006$gmane$org@iolanthe.rowland.org>
References: <200908190033.23502.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908190033.23502.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:

> There's a problem that for safety reasons I maintain the ordering of dpm_list
> and the callbacks are scheduled for async execution in the same order in
> which they would have been executed synchronously.  If were to change this,
> we'd have to be _very_ careful.

Why?  The order in which jobs are scheduled for async execution doesn't 
bear any particular relation to the order in which they get run.

Alan Stern
