From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Set policy to non-NULL only after all hotplug
 online work is done
Date: Tue, 25 Feb 2014 20:10:54 +0530
Message-ID: <CAKohponkjccKjc9xBQ3kCjdTMqFtKLCh1-mQXMS579+2_JmTCA@mail.gmail.com>
References: <1393225072-3997-1-git-send-email-skannan@codeaurora.org>
 <530BAA31.4050701@codeaurora.org>
 <CAKohpo=0CgzjCgKnDxUMcN6-CgbQ2ML=Tx-K8fS7=VJJYOD0eg@mail.gmail.com>
 <15001517.xLHO8lGdWr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <15001517.xLHO8lGdWr@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 25 February 2014 18:34, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Well, that depends on what the current users expect it to look like initially.
> It should be initialized to the point in which all of them can handle it
> correctly.

Exactly.

> That's not going to work in at least some cases anyway, because for some types
> of HW we simply can't retrieve the current frequency in a non-racy way.

I agree. But this is all that we can guarantee here :)
