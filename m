From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 1/2] cpufreq: scmi: Don't validate the frequency table
 twice
Date: Mon, 9 Apr 2018 13:39:44 +0200
Message-ID: <CAJZ5v0hGgLAK2MRx0tEpTt5Hh9i_9zwhFJPsOsxQ+fOSiLBr_w@mail.gmail.com>
References: <cover.1522749887.git.viresh.kumar@linaro.org>
 <442ecfd0a5bddf32c912c449b072d8a0139318fc.1522749887.git.viresh.kumar@linaro.org>
 <5ce48bce-4fcf-1e0a-6b78-f588fbf7e4a5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5ce48bce-4fcf-1e0a-6b78-f588fbf7e4a5@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 4, 2018 at 11:48 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> (I have exact patches ready :), was on vacation)

What am I expected to do with this one?

> On 03/04/18 11:07, Viresh Kumar wrote:
>> The cpufreq core is already validating the CPU frequency table after
>> calling the ->init() callback of the cpufreq drivers and the drivers
>> don't need to do the same anymore. Though they need to set the
>> policy->freq_table field directly from the ->init() callback now.
>>
>> Stop validating the frequency table from scmi driver.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
