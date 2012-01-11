From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Wed, 11 Jan 2012 09:26:22 +0200
Message-ID: <87vcoid7j5.fsf@amiettinen-lnx.nvidia.com>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<201201092227.29857.rjw@sisk.pl>
	<87ty44czeu.fsf@amiettinen-lnx.nvidia.com>
	<201201102144.00903.rjw@sisk.pl>
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
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:
> On Monday, January 09, 2012, Antti P Miettinen wrote:
>> Hmm.. congestion is an issue for latency requests as well.
>
> I'm not sure what you mean.  Care to elaborate?
>
> Rafael

Well, I was just thinking that latencies can get hurt by system load
just like throughput can suffer from load. By blocking sleep states we
can address "system level latency" or "best case latency" but as far as
I can see PM QoS does not address "worst case latency". So minimum CPU
frequency would be somewhat analogous - a "best case" or "system level"
QoS concept.

	--Antti
