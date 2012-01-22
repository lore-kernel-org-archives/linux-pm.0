From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Sun, 22 Jan 2012 12:35:14 +0200
Message-ID: <87d3acf2jh.fsf@amiettinen-lnx.nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<20120119164144.GA8757@mgross-G62>
	<87y5t35v96.fsf@amiettinen-lnx.nvidia.com>
	<201201192315.22590.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:
> On Thursday, January 19, 2012, Antti P Miettinen wrote:
>> I think we need both, global and per cpu.
>
> Well, if we have that per CPU, it will be easy to create a global
> setting: set all of the per-CPU settings to the same values. :-)

That is true. Currently the device specific constraints do not have user
space interface. The pm_qos_interface.txt refers to ongoing
discussion. Is there a thread I should read?

Seems that the device specific constraints are not yet in use in
3.3-rc1, or am I not looking hard enough?

	--Antti
