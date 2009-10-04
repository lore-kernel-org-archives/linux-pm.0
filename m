From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: 2.6.32-rc1: various BUGs on resume from hibernation
Date: Sun, 04 Oct 2009 18:03:36 +0100
Message-ID: <4AC8D568.9090103@tuffmail.co.uk>
References: <4AC8B4A8.3050601@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AC8B4A8.3050601@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Kernel Testers List <kernel-testers@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Alan Jenkins wrote:
> I'm seeing a variety of BUGs on my EeePC 701 after hibernation.  
> Sometimes they cause a hang during resume; sometimes they happen just 
> after resume.  It doesn't happen all the time either -  I've just 
> hibernated three times in a row with no problems.  It's most perplexing.
>
> One resume hang showed a series of SCSI backtraces and errors.  
> Unfortunately I wasn't able to capture it at the time.  They were most 
> probably related to the root device, an SSD controlled by ata_piix.
>
> Today on latest -git I captured this "bad swap file entry" problem.  I 
> use a swap file for hibernation (I don't have a swap partition).

> Previously, on a slightly older kernel (still after 32-rc1), I 
> captured this BUG in fget_light():

And later suspend to ram failed, and then showed a hung task warning.

I've attached everything at 
<http://bugzilla.kernel.org/show_bug.cgi?id=14320>.

Thanks
Alan
