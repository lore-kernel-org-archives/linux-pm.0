From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [v2 PATCH 0/4] timers: framework for migration
	between CPU
Date: Thu, 5 Mar 2009 16:14:51 -0800
Message-ID: <20090305161451.0da40645__31084.6632266932$1236298693$gmane$org@infradead.org>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090304121249.GA9855@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: arun@linux.vnet.ibm.com
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Mar 2009 17:42:49 +0530
Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:
> With the timers queued I measure the sleep state residency
> for a period of 10s.
> Next, I enable timer migration and measure the sleep state
> residency period.

is your table in seconds? Because realistically, at least on PC like
hardware, doing work to get sleep times over a 100 / 200 msecs or so
isn't going to save you any amount of measurable power anymore...



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
