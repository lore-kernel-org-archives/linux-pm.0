From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH v4] pm_qos: make update_request non blocking
Date: Wed, 09 Jun 2010 12:07:25 -0400
Message-ID: <1276099645.4343.257.camel__33500.2517480918$1276099753$gmane$org@mulgrave.site>
References: <1276097381-3982-1-git-send-email-florian@mickler.org>
	<1276097832.4343.223.camel@mulgrave.site>
	<20100609180033.39d5b499@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100609180033.39d5b499@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Frederic Weisbecker <fweisbec@gmail.com>, markgross@thegnar.org, linville@tuxdriver.com, linux-kernel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-06-09 at 18:00 +0200, Florian Mickler wrote:
> On Wed, 09 Jun 2010 11:37:12 -0400
> James Bottomley <James.Bottomley@suse.de> wrote:
> 
> 
> > This still isn't resilient against two successive calls to update.  If
> > the second one gets to schedule_work() before the work of the first one
> > has finished, you'll corrupt the workqueue.
> 
> Sorry, I don't see it. Can you elaborate?
> 
> In "run_workqueue(" we do a list_del_init() which resets the
> list-pointers of the workitem and only after that reset the
> WORK_STRUCT_PENDING member of said structure. 
> 
> 
> schedule_work does a queue_work_on which does a test_and_set_bit on
> the WORK_STRUCT_PENDING member of the work and only queues the work
> via list_add_tail in insert_work afterwards.
> 
> Where is my think'o? Or was this fixed while you didn't look?
> 
> So what _can_ happen, is that we miss a new notfication while the old
> notification is still in the queue. But I don't think this is a problem.

OK, so the expression of the race is that the latest notification gets
lost.  If something is tracking values, you'd really like to lose the
previous one (which is now irrelevant) not the latest one.  The point is
there's still a race.

James
