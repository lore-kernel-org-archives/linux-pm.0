From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Re: Re: "mm: move pcp and lru-pcp draining into single wq" broke
 resume from s2ram
Date: Wed, 19 Apr 2017 15:50:01 -0700
Message-ID: <CA+55aFxQOJp0jq4Z9pFQzZtyc7KHapVT=ZbYyUufyGQhY=DvkQ@mail.gmail.com>
References: <201704190541.v3J5fUE3054131@www262.sakura.ne.jp>
 <20170419071039.GB28263@dhcp22.suse.cz> <201704190726.v3J7QAiC076509@www262.sakura.ne.jp>
 <20170419075712.GB29789@dhcp22.suse.cz> <CAMuHMdVmJrr6_sGeU4oxH5fn10BRdLC5nOEePN05p3kJ1x3YBQ@mail.gmail.com>
 <20170419081701.GC29789@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170419081701.GC29789@dhcp22.suse.cz>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux PM list <linux-pm@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 19, 2017 at 1:17 AM, Michal Hocko <mhocko@kernel.org> wrote:
>
> Thanks for the testing. Linus will you take the patch from this thread
> or you prefer a resend?

I'll take it from this branch since I'm looking at it now, but in
general I prefer resends just because finding patches deep in some
discussion is very iffy.

I get too much email, so it really helps to make the patches more
explicit than this...

              Linus
