From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 1/2] cpufreq: scmi: Don't validate the frequency table
 twice
Date: Tue, 10 Apr 2018 08:42:47 +0200
Message-ID: <CAJZ5v0jwTevHFss-CriUDavLFT2mvZKVb2Bnm2bYxBbAy4zfzA@mail.gmail.com>
References: <cover.1522749887.git.viresh.kumar@linaro.org>
 <442ecfd0a5bddf32c912c449b072d8a0139318fc.1522749887.git.viresh.kumar@linaro.org>
 <5ce48bce-4fcf-1e0a-6b78-f588fbf7e4a5@arm.com>
 <CAJZ5v0hGgLAK2MRx0tEpTt5Hh9i_9zwhFJPsOsxQ+fOSiLBr_w@mail.gmail.com>
 <d86012d8-f98f-b9e9-aa0b-032ef0ee9c9c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d86012d8-f98f-b9e9-aa0b-032ef0ee9c9c@arm.com>
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 9, 2018 at 3:20 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 09/04/18 12:39, Rafael J. Wysocki wrote:
>> On Wed, Apr 4, 2018 at 11:48 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
>>> (I have exact patches ready :), was on vacation)
>>
>> What am I expected to do with this one?
>>
>
> Sorry for not being explicit. I assumed you can pick up this patch along
> with 2/2 removing the function, that's why I just acked the patch. The
> SCMI code is now merged.

OK, applied now, thanks!
