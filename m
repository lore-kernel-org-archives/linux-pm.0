From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 31 May 2010 09:06:42 +0300
Message-ID: <4C0351F2.8030709@nokia.com>
References: <1272667021-21312-1-git-send-email-arve@android.com>	<87wrvl5479.fsf@deeprootsystems.com>	<20100503215028.GB18910@srcf.ucam.org>	<alpine.DEB.2.00.1005141408260.3348@utopia.booyaka.com>	<20100514203202.GA12409@srcf.ucam.org>	<87aas2azc5.fsf@deeprootsystems.com>	<20100514231510.GG16989@thunk.org>	<87r5laa4oc.fsf@deeprootsystems.com>
	<20100530122143.GA6405@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100530122143.GA6405@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu, Kevin Hilman <khilman@deeprootsystems.com>, Matthew Garrett <mjg@redhat.com>, Paul Walmsley <paul@pwsan.com>, linux-pm@lists.linux-foundation.org, linux-ke
List-Id: linux-pm@vger.kernel.org

ext tytso@mit.edu wrote:

> On Mon, May 17, 2010 at 09:12:03AM -0700, Kevin Hilman wrote:
>   
>> The n900 *never* suspends.  It only uses dynamic PM + CPUidle.
>> The droid uses opportunistic suspend (as well as dynamic PM + CPUidle)
>>
>> I don't know of any more objective comparison of the two, but as a
>> user of both devices I can say that the active usage is basically the
>> same (around a day) and the idle use is similar as well, even though
>> the Droid has a slightly bigger battery (1400 mAh vs. 1320 mAh.)....
>>     
>
> Just for a bit of light amusement, although hopefully we've killed the
> meme that other platforms have absolutely no problems in this area
> without using something like suspend blockers,

If you are advocating QoS, I think it's a general agreement that 
something like that is needed.

If you are saying that suspend blockers - or the like - are needed, no, 
that is not true.
>  I offer for your
> consideration this thread from maemo-developers:
>
> http://lists.maemo.org/pipermail/maemo-developers/2010-May/026490.html
>
> Note how users conflate battery lifetime after downloading a random
> application with the platform being "stable".  I also was amazed that
> the thread degenerated into trying to detect processes that are taking
> 90% of the CPU.  It's not necessary for a process to be constantly
> running before it starts chewing up your battery, and if people think
> the "blame the victim" trick works (``It's the user's fault for
> "approving" the application by installing it!''), I suspect that
> the platform will be not be very successful...
>   
 From the thread - if i have not missed it - the user doesn't say if 
this is a newly flashed device or if he has done an upgrade of something 
he used to hack with. Erroneous settings might be an explanation there ...

Yes, I am blaming the victim, mostly out of previous experience in 
similar cases.

 From a platform pov I think this mostly proves the need to embed more 
self diagnostic in the system and have QoS.

igor
