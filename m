From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 15/27] cpufreq: powerenv: Don't validate the frequency
 table twice
Date: Tue, 27 Feb 2018 09:15:27 +0530
Message-ID: <20180227034527.GQ26947@vireshk-i7>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
 <3120e4db4ae3bc014d198a206f46be1305ec65e8.1519620578.git.viresh.kumar@linaro.org>
 <871sh89dbr.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <871sh89dbr.fsf@concordia.ellerman.id.au>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On 26-02-18, 22:53, Michael Ellerman wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> > Subject: Re: [PATCH 15/27] cpufreq: powerenv: Don't validate the frequency table twice
>                                            ^
>                                       powernv
> 
> > The cpufreq core is already validating the CPU frequency table after
> > calling the ->init() callback of the cpufreq drivers and the drivers
> > don't need to do the same anymore. Though they need to set the
> > policy->freq_table field directly from the ->init() callback now.
> >
> > Stop validating the frequency table from powerenv driver.

                                             powernv :)

Will fix both of them.

-- 
viresh
