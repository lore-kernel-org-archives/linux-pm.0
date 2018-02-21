From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
Date: Wed, 21 Feb 2018 11:17:15 +0100
Message-ID: <CAJZ5v0hCQCo3EwprC7RP5Jsn8_tMp-1fbMcPwKgujiQ8YeH0aA@mail.gmail.com>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7> <874lmasxxx.fsf@concordia.ellerman.id.au>
 <20180221055450.GO28462@vireshk-i7>
 <CAJZ5v0jEg7FELH6mBY16mB5sfo7s2mbH2SGheH4KVeKLnStjjg@mail.gmail.com>
 <20180221100209.GP28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180221100209.GP28462@vireshk-i7>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 21, 2018 at 11:02 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-02-18, 10:27, Rafael J. Wysocki wrote:
>> To be precise, ->init() should fail as that's where the table is
>> created.  The registration fails as a result then.
>>
>> But what if the bug is that ->init() doesn't fail when it should?
>>
>> I guess the core could double check the frequency table after ->init()
>> if ->target_index is not NULL.
>>
>> The overall point here is that if you get a negative index in
>> ->fast_switch(), that's way too late anyway and we should be able to
>> catch that error much earlier.
>
> I don't want to end up doing double checking as some of it is already
> done at init, but let me check on what can be done.

The driver is expected to call cpufreq_table_validate_and_show() at
->init() time and fail ->init() if that fails.

That's kind of fragile, because it depends on the driver to do the right thing.
