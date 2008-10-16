From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC PATCH 0/4] timers: Timer migration
Date: Thu, 16 Oct 2008 07:37:49 -0700
Message-ID: <20081016073749.4f944a19__37083.1371205442$1224168358$gmane$org@infradead.org>
References: <20081016114239.GA7641@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081016114239.GA7641@linux.vnet.ibm.com>
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

On Thu, 16 Oct 2008 17:12:39 +0530
> 
> 
> Here's a brief introduction as to why we need timer migration.
> 

as I've said before, for reducing power consumption I don't buy into
needing this concept....

If you have high frequency timers, you've lost no matter what (and we
fixed almost all of them in the ecosystem); if you don't have those
then this patch doesn't really add anything.
(and the range-hrtimers fixes the intermediate state)

-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
