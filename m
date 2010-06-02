From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH] pm_qos: remove unnecessary list-traversal
Date: Wed, 2 Jun 2010 08:14:32 +0200
Message-ID: <20100602081432.7a5e5f5d__26684.8903884695$1275459335$gmane$org@schatten.dmk.lab>
References: <1275382014-10178-1-git-send-email-florian@mickler.org>
	<1275382331-15180-1-git-send-email-florian@mickler.org>
	<alpine.LFD.2.00.1006011240360.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006011240360.2933@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: 640e9920@gmail.com, markgross@thegnar.org, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Linux@smtp1.linux-foundation.org, PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Jun 2010 12:43:21 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 1 Jun 2010, florian@mickler.org wrote:
> 
> > The new extreme value is only depending on the old extreme value and
> > the changed value.
> 
> And how does that update to the next applicable constraint when the
> current constraint is removed ? Your patch is creating a one way
> decision.

keeping the list sorted or using an rbtree is the answer then. 

if O(1) behaviour is needed maybe another constraint type could be
implemented. Maybe using a bool or even a bitmap (to allow for 32
constraint-values). 
Is another constraint-type worthwile? 

>  
> > Signed-off-by: Florian Mickler <florian@mickler.org>
> > ---
> > This version actually compiles...  :)
> 
> That does not make it work.
> 
>      tglx

indeed.

Cheers,
Flo
