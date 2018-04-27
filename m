From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2][for 4.17-rc3] cpufreq / CPPC: Set platform specific
 transition_delay_us
Date: Fri, 27 Apr 2018 10:22:48 +0530
Message-ID: <20180427045248.sugty3eng7o5bgbv@vireshk-i7>
References: <1524673572-27941-1-git-send-email-pprakash@codeaurora.org>
 <20180426052525.snsw3hzflabvfer3@vireshk-i7>
 <d65edca1-616d-7766-5aca-b8942bc971b1@codeaurora.org>
 <04fdd4d1-fd78-f6c9-4852-45a0c6235e7f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <04fdd4d1-fd78-f6c9-4852-45a0c6235e7f@codeaurora.org>
Sender: stable-owner@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, "4.14+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 26-04-18, 09:50, Prakash, Prashanth wrote:
> On second thoughts, If we have a scenario where we have a platform on which the
> "implementor" matches a case statement, but the "part_num" does not have a
> corresponding case statement. In this case we would need multiple levels of default,
> so I think the current implementation is simpler. 

You already have multiple level of switches, multiple level of
defaults shouldn't make it any worse :)

-- 
viresh
