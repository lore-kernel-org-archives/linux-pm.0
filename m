From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: invoke suspend notifications after console
	switch
Date: Thu, 10 Jan 2008 18:00:32 +0100
Message-ID: <200801101800.32921.rjw@sisk.pl>
References: <1197853799.4885.7.camel@johannes.berg>
	<1199970876.3861.66.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1199970876.3861.66.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 10 of January 2008, Johannes Berg wrote:
> 
> On Mon, 2007-12-17 at 02:09 +0100, Johannes Berg wrote:
> > A subsequent patch will enable apm-emulation notification for suspends
> > triggered in any way by using the suspend notifications. This causes
> > the system to lock up between X being needed to switch away from the
> > VT and X already waiting for resume in the apm ioctl.
> > 
> > This patch moves the console switch (if enabled) before the suspend
> > notification (and after the resume notification) to avoid this issue.
> 
> I don't see this in the suspend git tree yet, anything wrong with it?

No, it's fine.

I was distracted by the recent ACPI ordering issue, will push it to Len
shortly.

Thanks,
Rafael
