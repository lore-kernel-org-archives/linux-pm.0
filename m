From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [TuxOnIce-devel] Nigel's current for-rafael queue
Date: Wed, 29 Sep 2010 07:25:45 +1000
Message-ID: <4CA25D59.2040409__41061.4299624742$1285709272$gmane$org@tuxonice.net>
References: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
	(sfid-20100925_095651_884433_67642C74)
	<201009282145.46948.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009282145.46948.Martin@lichtvoll.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Martin.

On 29/09/10 05:45, Martin Steigerwald wrote:
> Am Samstag 25 September 2010 schrieb Nigel Cunningham:
>> Hi Rafael.
>
> Hi Nigel,
>
>> Please find attached a slightly updated version of the patchset I sent
>> a few months ago. The main change is that I've prepended and additional
>> patch which lets the user see the speed at which the image is being
>> read and written. This is accomplished by recording the MB/s in a
>> single byte in the image header, and using a couple of __nosavedata
>> variables to get the data back through the atomic restore. I realise
>> the char limits us to 255MB/s at the moment. In future patches, I
>> intend to address this by storing the data in a 'proper' image header
>> (it's a real problem - TuxOnIce reads and writes on the same set up at
>> speeds around 250MB/s).
>>
>> Results on my Dell XPS M1530, which has an SSD hard drive are:
>
> I found one issue with this patchset or more precise I think with the
> state of in-kernel-suspend before:
>
> I accidentally booted a kernel without your patches and it didn't seem to
> stop on the hibernation image from the kernel with your patches. Well I
> let my laptop unattended for a little while, so when there has been a
> (short) timeout, I might have missed that message.
>
> I lost a hibernation image this way which caused successful journal replay
> on my Ext4 filesystems.
>
> Does a kernel without your patches offer to reboot into the correct kernel,
> then it finds a hibernation image from a kernel with your patches?
>
> If not, I think for the future it should give a warning with a quite high
> timeout, and offer to reboot into the right kernel.

My patches only focus on the I/O code in swsusp at the moment. I know 
there are still tons of things from TuxOnIce that could be put into 
swsusp, but at the moment I'm just focusing on I/O code.

The answer at the moment is therefore "I'm sorry, but if you're going to 
try out this code, you're going to have to live without some of 
TuxOnIce's nice features until I can split them into nice little 
patches, and start trying to persuade Rafael they're a good idea to merge."

Sorry!

Nigel
