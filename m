From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Tue, 08 Jan 2008 19:06:56 +0100
Message-ID: <4783BBC0.2070802__6595.50702334872$1199815878$gmane$org@s5r6.in-berlin.de>
References: <Pine.LNX.4.44L0.0801081006580.2643-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801081006580.2643-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern wrote:
> On Tue, 8 Jan 2008, Oliver Neukum wrote:
>> Am Montag, 7. Januar 2008 20:42:23 schrieb Alan Stern:
>> >  /**
>> > + *     autoresume - perform dynamic (runtime) host resume
[...]
>> This seems to be a bit misleading. It seems to me that you must cancel
>> any outstanding request to autosuspend from other layers.
> 
> How about something more like this:
> 
> *	Resume (return to an operational power level) the specified host,
> *	and prevent autosuspends from other software layers until the
> *	template autosuspend method has been called again.
> *	Return 0 if the resume was successful, otherwise a negative
> *	error code.

Who prevents them?  The autoresume() implementation, or its caller?
-- 
Stefan Richter
-=====-==--- ---= -=---
http://arcgraph.de/sr/
