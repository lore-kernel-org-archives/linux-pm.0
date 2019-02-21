From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: Add a predict callback for the governors
Date: Thu, 21 Feb 2019 17:18:25 +0100
Message-ID: <CAJZ5v0iCkMA=LVvV+-jqr8fCYz2mwaqtiKmNTfxf0dxZ=MvdiQ@mail.gmail.com>
References: <20190221145631.26356-1-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221145631.26356-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 21, 2019 at 3:56 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Predicting the next event on the current CPU is implemented in the
> idle state selection function, thus the selection logic and the
> prediction are tied together and it is hard to decorrelate both.
>
> The following change introduces the cpuidle function to give the
> opportunity to the governor to store the guess estimate of the
> different source of wakeup and then reuse them in the selection
> process. Consequently we end up with two separate operations clearly
> identified.
>
> As the next events are stored in the cpuidle device structure it is
> easy to propagate them in the different governor callbacks.

Can you explain a bit how you would use this new callback in a governor?
