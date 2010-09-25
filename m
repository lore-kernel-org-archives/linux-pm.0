From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: Nigel's current for-rafael queue
Date: Sun, 26 Sep 2010 08:33:51 +1000
Message-ID: <4C9E78CF.4090201__660.941462456499$1285454076$gmane$org@tuxonice.net>
References: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
	<201009260019.37438.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009260019.37438.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi.

On 26/09/10 08:19, Rafael J. Wysocki wrote:
> On Saturday, September 25, 2010, Nigel Cunningham wrote:
>> Hi Rafael.
>
> Hi Nigel,
>
>> Please find attached a slightly updated version of the patchset I sent
>> a few months ago. The main change is that I've prepended and additional
>> patch which lets the user see the speed at which the image is being
>> read and written. This is accomplished by recording the MB/s in a single
>> byte in the image header, and using a couple of __nosavedata variables
>> to get the data back through the atomic restore. I realise the char limits
>> us to 255MB/s at the moment. In future patches, I intend to address this
>> by storing the data in a 'proper' image header (it's a real problem -
>> TuxOnIce reads and writes on the same set up at speeds around 250MB/s).
>>
>> Results on my Dell XPS M1530, which has an SSD hard drive are:
>>
>> With just patch 1 applied:
>> Attempt 1: Write 74MB/s; Read 52MB/s
>> Attempt 2: Write 68MB/s; Read 52MB/s
>> Attempt 3: Write 73MB/s; Read 53MB/s
>>
>> With the whole sequence:
>> Attempt 1: Write 181MB/s; Read 52MB/s
>> Attempt 2: Write 156MB/s; Read 53MB/s
>> Attempt 3: Write 160MB/s; Read 52MB/s
>
> Thanks for the patches, they look like a real improvement to me.
>
> I only had a couple of minor comments, sent separately in replies to individual
> patches.  I'd like to push this series for 2.6.37, if the comments are
> addressed timely.

Okay. I'll update the patches. You can pull from

git://git.kernel.org/pub/scm/linux/kernel/git/nigelc/tuxonice-head.git#for-rafael

if you want.

I'll apply your suggestions/comments to the versions there. I'll also 
checkout what's going on with Martin's machine and hopefully apply 
whatever fix is needed there too. Will keep you up to date with any changes.

Regards,

Nigel
