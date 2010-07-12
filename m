From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH v2] pm: Add runtime PM statistics
Date: Sun, 11 Jul 2010 22:16:46 -0700
Message-ID: <20100711221646.35f11b70__6371.43615535951$1278911658$gmane$org@infradead.org>
References: <20100710095254.5ab7291c@infradead.org>
	<201007112326.07541.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007112326.07541.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 11 Jul 2010 23:26:07 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > +
> >  static DEVICE_ATTR(runtime_usage, 0444, rtpm_usagecount_show,
> > NULL); static DEVICE_ATTR(runtime_active_kids, 0444,
> > rtpm_children_show, NULL); static DEVICE_ATTR(runtime_status, 0444,
> > rtpm_status_show, NULL); +static DEVICE_ATTR(runtime_active_time,
> > 0444, rtpm_active_time_show, NULL); +static
> > DEVICE_ATTR(runtime_suspended_time, 0444, rtpm_suspended_time_show,
> > NULL); static DEVICE_ATTR(runtime_enabled, 0444, rtpm_enabled_show,
> > NULL);
> 
> On a second thought, "active_time" and "suspended_time" should be
> sufficient (ie. the "runtime_" prefix is not really necessary).

it's not necessary but it's consistent with the others... so yes
I can change it but then it's no longer consistent naming.. are you sure
you want this changed?


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
