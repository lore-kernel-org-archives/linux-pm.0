From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: powernv: Fix crash in gpstate_timer_handler
Date: Wed, 10 Aug 2016 22:41:21 +1000
Message-ID: <87mvkkssni.fsf@concordia.ellerman.id.au>
References: <1470324557-20711-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160804164711.GE10348@ubuntu> <87oa51tfgg.fsf@concordia.ellerman.id.au>
 <9902339.J95Mxqndi6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <9902339.J95Mxqndi6@vostro.rjw.lan>
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
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> On Wednesday, August 10, 2016 02:28:47 PM Michael Ellerman wrote:
>> 
>> Who's merging this?
>
> I am.

Thanks!
