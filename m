From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 0/2] RFC: CPU frequency max as PM QoS param
Date: Mon, 20 Feb 2012 12:00:41 +0200
Message-ID: <87pqd94yeu.fsf@amiettinen-lnx.nvidia.com>
References: <1326976559-4009-1-git-send-email-amiettinen@nvidia.com>
	<87d39fk2n3.fsf@ti.com> <20120217030453.GA3266@gs62>
	<CAGF5oy9LC4Ve8u6UqG3EbGkWmWYVMthHatJdaRR_ZMO4UQh3CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Thanks for the comments. I'd like to comment on maximum CPU frequency,
sysfs files and per device contraints..

Maximum CPU frequency could be useful for thermal. However, it is not a
complete solution for thermal. Just like minimum CPU frequency is not a
complete solution for computing throughput (e.g. memory and accelerator
control are not directly addressed by a CPU frequency
constraint). Maximum CPU frequency can be also useful for energy
efficiency even though the constraint is not a complete solution here
either. I guess latency constraints do not completely solve end-to-end
latency requirements but the mechanism is useful so it is good to have
it. I'd argue minimum and maximum frequency are simular in this respect.

There are sysfs files for constraining CPU frequency. However, there is
no arbitration for several applications trying to place constraints. PM
QoS provides a way to consolidate requests from several applications and
cleanup upon application crash. I think the existing sysfs files are not
an appropriate inferface for user space applications.

Currently CPU sleep states are blocked globally for latency
contraints. Finer granularity control would be possible with per CPU
contraints. However - are there clients that know or want to contrain a
specific CPU? Same question is applicable also to CPU frequency. Even
though per CPU control is more flexible, what are the clients that want
to constrain a specific CPU?

Another complication for the per device constraints is the user space
interface. Dynamic minors run out pretty fast if we have per CPU
parameters and the system has huge number of CPUs. Does anyone have any
opinions about the user space interface for device PM QoS?

	--Antti
