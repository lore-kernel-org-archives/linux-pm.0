From: Raj Kumar <rajkumar278@hotmail.com>
Subject: Re: Runtime power management during system resume
Date: Tue, 24 Aug 2010 20:47:58 +0530
Message-ID: <BLU102-W5B0F0352A72D47CBA27CFEB830@phx.gbl>
References: <BLU102-W1030ED196ED7B94722F2A7EB830@phx.gbl>,
	<Pine.LNX.4.44L0.1008241029000.1652-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1008241029000.1652-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


 
Hi,
 
My question is:
 
1) When the system suspends, it invokes pm_runtime_put_sync when complete
callback is called which will again trigger to put device idle
 
means in runtime power management core, the device status is set to RPM_SUSPENDED.
right?
 
2) As you also said that during system resume, it does not increment the power_usage
counter,
 
that is ok, driver will increase the power_usage counter...
 
But will driver also set the state to RPM_ACTIVE means pm_runtime_set_active
 
right?
 
 
3) During hibernation, if the driver is registered using platform_driver_register...
 
When the system hibernates, will power management core call suspend, resume?
 
right?
 
Regards,
Raj
 
 
 
 
 
 


----------------------------------------
> Date: Tue, 24 Aug 2010 10:30:25 -0400
> From: stern@rowland.harvard.edu
> To: rajkumar278@hotmail.com
> CC: linux-kernel@vger.kernel.org
> Subject: Re: Runtime power management during system resume
>
> On Tue, 24 Aug 2010, Raj Kumar wrote:
>
>> Hi Alan,
>>
>> I have implemented the run time power management in my drivers. I have one
>> issue regarding System resume.
>>
>> When the system sleep is triggered as it is mentioned that Power management
>> core will increment the power_usage counter during prepare and decrements when complete
>> is called.
>>
>> Now I have few questions:
>>
>> 1) When the system resume is done, it does not increase the power_usage counter.
>> right?
>
> That's right.
>
>> So Does then the driver need to update the power_usage counter with run time power management
>> core and again set it to active means RPM_ACTIVE?
>
> Read section 6 of Documentation/power/runtime_pm.h. It explains this.
>
>> 2) Suppose device is active, means its power_usage counter is already one, Now during system
>> sleep, does the driver first suspend it with run time power management core and then continue
>> System suspend?
>
> No.
>
>> 3) Because I have seen the code of power management core and I did not see the that during
>> system suspend, run time power management status is updated means RPM_SUSPENDED.
>> right?
>
> I don't understand your question.
>
> Alan Stern
> 		 	   		  
