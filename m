From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 18:17:04 -0600
Message-ID: <468AE700.7080102__3182.29115005142$1183508543$gmane$org@shaw.ca>
References: <fa.ftLWBLCc+XqdYjiuxoPg+qyuUOE@ifi.uio.no>
	<fa.Oxrm8HYXTOF4jv5LrTjEe16lCE0@ifi.uio.no>
	<fa.d3GOse+YbAb42uYwLymWkJiH9Fw@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <fa.d3GOse+YbAb42uYwLymWkJiH9Fw@ifi.uio.no>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Matthew Garrett wrote:
> On Tue, Jul 03, 2007 at 06:21:42PM -0400, Alan Stern wrote:
>> On Tue, 3 Jul 2007, Matthew Garrett wrote:
>>> We're used to the idea of applications blocking when a resource they're 
>>> using goes away - NFS has done it forever. 
>> You persist in evading my point.  I'm not worried about applications;  
>> I'm worried about drivers.
>>
>> Let me put it explicitly: You're writing a driver.  You're working on
>> the read, write, or probe method.  You add code to check if a system
>> sleep is underway.  Suppose the answer is Yes -- what does your driver
>> do next?
> 
> Leave the process blocked and defer any i/o until after resume. Why does 
> it need to be any more complicated than that?

It gets complicated when this has to be added and TESTED in EVERY 
driver. The implied contract for drivers previously was that their 
device would not get accessed after it was suspended until it had been 
resumed first. This proposed change violates that.

I don't think this sort of handling is something that individual drivers 
should have to deal with (at least not ones that are part of a framework 
like USB, libata, etc.)

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
