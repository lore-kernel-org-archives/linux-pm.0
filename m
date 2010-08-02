From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 20:06:55 -0700
Message-ID: <20100801200655.7edcf247__28852.583297021$1280718453$gmane$org@infradead.org>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100802011006.GS2470@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Sun, 1 Aug 2010 18:10:06 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
 
> If I understand you correctly, a key point of agreement between you
> and the Android guys is that both the system and the user have some
> say over how applications are treated by the system in terms of how
> seriously the system takes a given application's requests.
> 
> The Android guys also want the user to have some say about what
> applications are permitted to have some control over "I want to go to
> <this magic deep idle state>" requests.  Does that seem reasonable
> to you?

I personally think it's one of those things where... well we can get a
LONG way automatically (by just observing things); asking the users
is very very often just caving in rather than solving the problem.

Asking the user should only be done for things the user
1) Can give an intelligent answer to
and
2) Are something the user WANTS to be involved in.
   (rather than 'stupid thing, why don't just do the right thing'..
   think the Windows Vista security questions)



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
