From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] Swsusp patches applied to
	suspend-2.6#linux-next
Date: Mon, 27 Sep 2010 21:39:14 +1000
Message-ID: <4CA08262.7090707__21352.8361906812$1285587595$gmane$org@tuxonice.net>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	<20100927080000.GA7032@wrars-comp.wrarsdomain>
	<4CA055EF.6050608@tuxonice.net>
	<20100927111631.GA6759@wrars-comp.wrarsdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100927111631.GA6759@wrars-comp.wrarsdomain>
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

On 27/09/10 21:16, Andrey Rahmatullin wrote:
> On Mon, Sep 27, 2010 at 06:29:35PM +1000, Nigel Cunningham wrote:
>>>> On my laptop, single-threaded compression actually slows writing down from
>>>> 175MB/s to around 100-120MB/s (depending on how well the image compresses).
>>>> Reading speed improves from 218MB/s to around 245MB/s. I expect that
>>>> multithreaded writing would bring the writing (and reading) speeds back
>>>> up. It's on my swsusp to do list :)
>>> Works here.
>> What sort of speeds are you seeing?
> [  343.549378] PM: Image written at 107 MB/s.
> [  343.549379] PM: Image read at 205 MB/s.
> Latest ToI (on .35; with the lzo compressor; no clue about
> multithreadedness, though there are 4 CPUs here): I/O speed: Write 166
> MB/s, Read 192 MB/s.

Cool. Thanks!

Nigel
