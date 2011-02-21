From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: 2.6.37.1 s2disk regression (TPM)
Date: Mon, 21 Feb 2011 21:39:47 +0100
Message-ID: <4D62CD93.3040206__41602.4308804937$1298322240$gmane$org@gmail.com>
References: <4D60E93D.1050205@gmail.com> <4D60F108.9000106@gmail.com>
	<201102201151.11635.rjw@sisk.pl> <201102201248.10779.rjw@sisk.pl>
	<4D628521.8000205@linux.vnet.ibm.com> <4D629427.8020500@gmail.com>
	<4D629D03.90801@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D629D03.90801@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rajiv Andrade <srajiv@linux.vnet.ibm.com>
Cc: stefanb@linux.vnet.ibm.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>, debora@linux.vnet.ibm.com, preining@logic.at, linux-pm <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/21/2011 06:12 PM, Rajiv Andrade wrote:
> On 02/21/2011 01:34 PM, Jiri Slaby wrote:
>> There has to be another problem which caused my regression. And since it
>> reports "Operation Timed out", the former default timeout values worked
>> for me, the ones read from TPM do not.
> Yes, it's highly due inconsistent timeout values reported by the TPM as
> I mentioned, my working timeouts are:
> 3020000 4510000 181000000

1000000 2000 150000

Actually the first one from HW is 1. This is one is HZ after correction
in get_timeout. So perhaps it is in ms, yes.

regards,
-- 
js
