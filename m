From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Hibernation partition at Linux
Date: Fri, 21 May 2010 08:17:14 +1000
Message-ID: <4BF5B4EA.3010804@crca.org.au>
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

Hi.

On 21/05/10 06:24, H.Christ-T.Strieder@t-online.de wrote:
> Hello,
>
> in line with an composition we would need more information about the
> partition structure and content that is used when Linux does
> hibernation (suspend to disk). Does anybody have a tip where we can
> get documentation on this?
>
> Thanks in advance Thomas Strieder

Linux doesn't have hibernation partitions. It has support for swap 
partitions and swap files on normal filesystems, which can be used to 
page out memory during the normal running of the system. Hibernation in 
Linux uses available space in this area for writing the hibernation image.

Regards,

Nigel
