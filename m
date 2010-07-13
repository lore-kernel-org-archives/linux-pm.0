From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] pm: Add runtime PM statistics
Date: Tue, 13 Jul 2010 23:28:28 +0200
Message-ID: <201007132328.28853.rjw__40721.6880390935$1279058475$gmane$org@sisk.pl>
References: <20100710095254.5ab7291c@infradead.org>
	<201007112326.07541.rjw@sisk.pl>
	<20100711221646.35f11b70@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100711221646.35f11b70@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, July 12, 2010, Arjan van de Ven wrote:
> On Sun, 11 Jul 2010 23:26:07 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > +
> > >  static DEVICE_ATTR(runtime_usage, 0444, rtpm_usagecount_show,
> > > NULL); static DEVICE_ATTR(runtime_active_kids, 0444,
> > > rtpm_children_show, NULL); static DEVICE_ATTR(runtime_status, 0444,
> > > rtpm_status_show, NULL); +static DEVICE_ATTR(runtime_active_time,
> > > 0444, rtpm_active_time_show, NULL); +static
> > > DEVICE_ATTR(runtime_suspended_time, 0444, rtpm_suspended_time_show,
> > > NULL); static DEVICE_ATTR(runtime_enabled, 0444, rtpm_enabled_show,
> > > NULL);
> > 
> > On a second thought, "active_time" and "suspended_time" should be
> > sufficient (ie. the "runtime_" prefix is not really necessary).
> 
> it's not necessary but it's consistent with the others... so yes
> I can change it but then it's no longer consistent naming.. are you sure
> you want this changed?

No, you're right, sorry.

But can you rebase your patch on top of linux-next, please, and move the
definitions of the new attributes next to 'control' and 'runtime_status' (so
that they don't depend on 'debug')?

Rafael
