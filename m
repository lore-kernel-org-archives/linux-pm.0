From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from menu_select()
Date: Fri, 5 Oct 2018 10:49:40 +0200
Message-ID: <CAJZ5v0iysZaRY92ocQisAM3jaRUzoaQYrsbGXs4WwntEKMbLCQ@mail.gmail.com>
References: <3510260.hvypppS8Bs@aspire.rjw.lan> <4130376.2FFt7p4687@aspire.rjw.lan>
 <20181004145116.GB1881@mai> <CAJZ5v0h1Z7MKjq9XY0-tn9U4J3CdycYPbGkM3fjH7-FzaJ=uJA@mail.gmail.com>
 <b365081f-00bb-ec2a-84b2-48bed1b76c19@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b365081f-00bb-ec2a-84b2-48bed1b76c19@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 5, 2018 at 10:35 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 04/10/2018 19:19, Rafael J. Wysocki wrote:
> > On Thu, Oct 4, 2018 at 4:51 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Rearrange the code in menu_select() so that the loop over idle states
> >>> always starts from 0 and get rid of the first_idx variable.
> >>>
> >>> While at it, add two empty lines to separate conditional statements
> >>> one another.
> >>>
> >>> No intentional behavior changes.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>
> >> This code is becoming a bit complex to follow :/
> >>
> >> May be I missed something, but it is not possible to enter the condition without
> >> idx != 0, no ? (I meant the condition if ((drv->states[idx].flags &
> >> FLAG_POLLING))
> >
> > Not sure what you mean.
>
> Yes, sorry let me clarify.
>
> I meant the flag polling is always on state[0], so if the flag is set
> then idx == 0.
>
> We have the conditions:
>
>   drv->states[idx].flags & CPUIDLE_FLAG_POLLING
>
> If it is true then idx is zero.
>
>
> Then comes the second condition:
>
>   i == idx + 1
>
> because of the above, idx is zero, then it can become i == 1.
>
> Then the variable assignation:
>
>  idx = i can be replaced by idx = 1

Yes, but the former works too. :-)
