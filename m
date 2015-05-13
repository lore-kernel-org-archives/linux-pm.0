From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] PM, freezer: Don't thaw when it's intended frozen
 processes
Date: Wed, 13 May 2015 09:54:38 -0400
Message-ID: <20150513135438.GR11388@htj.duckdns.org>
References: <20150507064557.GA26928@july>
 <20150507154212.GA12245@htj.duckdns.org>
 <CAH9JG2UAVRgX0Mg0d7WgG0URpkgu4q_bbNMXyOOEh9WFPztppQ@mail.gmail.com>
 <20150508152513.GB28439@htj.duckdns.org>
 <CAH9JG2VROCekWCAa+1t6Giy2wHC171TD-AXQVxG2vTH-LPcoPA@mail.gmail.com>
 <CAH9JG2W6pKi__g-v+9B+-y3HJ=AkdE+W0d0TxmtpBWrXddxL_g@mail.gmail.com>
 <20150512144313.GO11388@htj.duckdns.org>
 <CAH9JG2WffvJCB7v1peL3vWbJoJwZH=h8g-o0TmkmfUpsgVci0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CAH9JG2WffvJCB7v1peL3vWbJoJwZH=h8g-o0TmkmfUpsgVci0A@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "\\Rafael J. Wysocki\\" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 13, 2015 at 09:42:47AM +0900, Kyungmin Park wrote:
> Right, it's still in freezer, just one time scheduling is happened.
> and enter freeze state again.
> 
> do you think can we avoid it or it's sub-optimal to do as patch?

I mean, it's suboptimal.  I'm not sure it actually matters tho.  If it
matters, please feel free to submit a patch with proper rationale.
Please just be careful so that we don't miss sending out wakeup in
case we race against thawing.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
