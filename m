From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] Swsusp patches applied to
	suspend-2.6#linux-next
Date: Mon, 27 Sep 2010 19:57:41 +1000
Message-ID: <4CA06A95.7040303__41861.4706527025$1285581506$gmane$org@tuxonice.net>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<20100927080000.GA7032@wrars-comp.wrarsdomain>
	<4CA055EF.6050608@tuxonice.net>
	<20100927093826.GA6904@wrars-comp.wrarsdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100927093826.GA6904@wrars-comp.wrarsdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@altlinux.org>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi.

On 27/09/10 19:38, Andrey Rahmatullin wrote:
> On Mon, Sep 27, 2010 at 06:29:35PM +1000, Nigel Cunningham wrote:
>>>> As discussed, here are the patches, modified to apply against your current
>>>> linux-next tree. A new first patch splits compression support out into its
>>>> own file, removing the need to have two versions of the load_image and
>>>> save_image routines, minimising the changes to the remainder of the
>>>> patches and making things cleaner than would otherwise be the case.
>>>>
>>>> On my laptop, single-threaded compression actually slows writing down from
>>>> 175MB/s to around 100-120MB/s (depending on how well the image compresses).
>>>> Reading speed improves from 218MB/s to around 245MB/s. I expect that
>>>> multithreaded writing would bring the writing (and reading) speeds back
>>>> up. It's on my swsusp to do list :)
>>> Works here.
>>
>> Ah. You're too fast for me :)
>>
>> What sort of speeds are you seeing?
> Well, I don't see any 'PM: Image read at' etc in the kernel logs after
> resuming (in for-rafael tree).

You need CONFIG_PM_DEBUG enabled for that. Perhaps I should remove that 
requirement.

Nigel
