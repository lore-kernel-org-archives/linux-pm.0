From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [PATCH 03/23] Hibernation: Swap iteration functions.
Date: Wed, 06 Oct 2010 12:22:32 +1100
Message-ID: <4CABCF58.1090903__11302.9555338018$1286328373$gmane$org@tuxonice.net>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<1285566238-10966-4-git-send-email-nigel@tuxonice.net>
	<20101004175457.GC1518@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101004175457.GC1518@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi.

On 05/10/10 04:54, Pavel Machek wrote:
> On Mon 2010-09-27 15:43:38, Nigel Cunningham wrote:
>> Add the data structure 'storage_position' and routines that allow
>> a caller to iterate over swap in sector order. Note that calling
>> reset_storage_pos only resets the position. next_swapdev_block
>> must also be called to get the address of the first (and subsequent
>> sectors).
>>
>> Signed-off-by: Nigel Cunningham<nigel@tuxonice.net>
>
> Merge this with 8/23? AFAICT, this creates unused functions here only
> to move them in later patch.

Okay. I've merged a couple of the others together too. I hope to send a 
new set in a while.

Regards,

Nigel
