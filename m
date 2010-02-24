From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: runtime PM: common hooks for static and runtime PM
Date: Wed, 24 Feb 2010 22:32:20 +0000
Message-ID: <DE9F524D-B8B9-41A0-B774-BC10097A317E@sirena.org.uk>
References: <Pine.LNX.4.44L0.1002241354560.1253-100000@iolanthe.rowland.org>
	(sfid-20100224_185637_724885_D7A3AE40)
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002241354560.1253-100000@iolanthe.rowland.org>
	(sfid-20100224_185637_724885_D7A3AE40)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 24 Feb 2010, at 18:56, Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, 24 Feb 2010, Mark Brown wrote:
>
>> On Mon, Feb 08, 2010 at 09:54:07AM -0500, Alan Stern wrote:
>>> On Sat, 6 Feb 2010, Alan Stern wrote:
>>
>>>> I'll give it a try and we'll see how it turns out...
>>
>>> And here it is.  You can see that the patch isn't ideal.
>>
>>> Anyway, it should do what you want -- I haven't tested it.
>>
>> It's taken a little while to test (and to be frank my testing is  
>> paper
>> thin) but it looks like this does what I'm looking for - thanks!
>
> But should that patch be submitted for inclusion in the kernel,
> warts and all?

My feeling is that it solves a real problem so yes and if it turns out  
there are issues we can always bug fix it later - if it's not merged  
then cross tree issues would mean that there'd be a substantial lag  
before it could be used in drivers.
