From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/6] RFC: CPU frequency min/max as PM QoS
	params
Date: Tue, 10 Jan 2012 21:44:00 +0100
Message-ID: <201201102144.00903.rjw@sisk.pl>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
	<201201092227.29857.rjw@sisk.pl>
	<87ty44czeu.fsf@amiettinen-lnx.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87ty44czeu.fsf@amiettinen-lnx.nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 09, 2012, Antti P Miettinen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > Well, I'd say it's necessary for correctness, perhaps not for the CPU, but in
> > general.  If Y is the max, then the subsystem that requested X may easily
> > starve whoever requested the Y by using all of the bandwidth it asked for.
> 
> Hmm.. congestion is an issue for latency requests as well.

I'm not sure what you mean.  Care to elaborate?

Rafael
