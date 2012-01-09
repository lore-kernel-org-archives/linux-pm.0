From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Mon, 09 Jan 2012 23:57:13 +0200
Message-ID: <87ty44czeu.fsf@amiettinen-lnx.nvidia.com>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<201201082359.25077.rjw@sisk.pl> <20120109142353.GC11463@mgross-G62>
	<201201092227.29857.rjw@sisk.pl>
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
> Well, I'd say it's necessary for correctness, perhaps not for the CPU, but in
> general.  If Y is the max, then the subsystem that requested X may easily
> starve whoever requested the Y by using all of the bandwidth it asked for.

Hmm.. congestion is an issue for latency requests as well. I've viewed
the current PM QoS handling system level requests. If we want some kind
of resource reservation/provisioning that could probably be layered on
top of system level requests, no?

	--Antti
