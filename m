From: david@lang.hm
Subject: Re: Re: Hibernation considerations
Date: Thu, 2 Aug 2007 20:50:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0708022049400.6905__35341.4258490831$1186151201$gmane$org@asgard.lang.hm>
References: <200707202335.05519.oliver@neukum.org>
	<Pine.LNX.4.44L0.0707201820050.5241-100000@iolanthe.rowland.org>
	<20070801093437.GC4808@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070801093437.GC4808@ucw.cz>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Wed, 1 Aug 2007, Pavel Machek wrote:

> Hi!
>
>>>  Do we have to block module loading?
>>
>> No.  Registering new drivers is okay, registering new devices is bad.
>>
>> Of course, some modules do want to register a new device in their init
>> method.  I don't know what we should do about them.  Force the
>> registration to fail, I suppose.  How often will people suspend while a
>> module is loading?
>
> Well... plug this pcmcia card into the slot so that I do not have to
> carry it separately, close the lid and go?
>
> ...not that impossible to imagine...

I useually leave my broadband card in the slot, but not seated. I wouldn't 
bet against it getting pushed in enough to be detected while putting the 
laptop in the bag.

David Lang
