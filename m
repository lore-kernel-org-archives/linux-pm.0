From: Mason <mpeg.blue@free.fr>
Subject: Re: RFC on cpufreq implementation
Date: Mon, 19 Jan 2015 23:03:54 +0100
Message-ID: <54BD7F4A.6020605@free.fr>
References: <54B7F7CD.7030903@free.fr>
 <CAKohponGjLkniP2=Aj-Jsg7hfAEnW3p0+EwtrobdCymgT-yqgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKohponGjLkniP2=Aj-Jsg7hfAEnW3p0+EwtrobdCymgT-yqgg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq <cpufreq@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 19/01/2015 08:52, Viresh Kumar wrote:
> On 15 January 2015 at 22:54, Mason wrote:
>> I decided to expose only a small subset of frequencies (namely
>> {999,500,333,111} MHz) because, in my tests, the ondemand gov
>> chose mostly min and max, and the intermediate frequencies not
>> so much; so I figured "2 intermediate freqs" is good enough.
>> (I'm ready to hear otherwise.)
> 
> Following patch solved this issue in 3.17..
> 
> 6393d6a1027e cpufreq: ondemand: Eliminate the deadband effect

Good to know, thanks! (I'm on 3.14)

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6393d6a1027ec1d69ec6246f6c7c2186f76c2abb

Do you have other comments/suggestions regarding my code?

Regards.
