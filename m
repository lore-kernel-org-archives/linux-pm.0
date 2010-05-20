From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation partition at Linux
Date: Fri, 21 May 2010 00:13:14 +0200
Message-ID: <201005210013.14681.rjw@sisk.pl>
References: <1OFCIR-0Jl2si0@fwd07.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1OFCIR-0Jl2si0@fwd07.aul.t-online.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: H.Christ-T.Strieder@t-online.de
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 20 May 2010, H.Christ-T.Strieder@t-online.de wrote:
> Hello,
> 
> in line with an composition we would need more information about the
> partition structure and content that is used when Linux does hibernation
> (suspend to disk). Does anybody have a tip where we can get documentation
> on this?

It has to be a normal swap partition or a swap file located on a regular
parition (see Documentation/power/swsusp-and-swap-files.txt in the kernel
tree for some information about how swap files are used).

Thanks,
Rafael
